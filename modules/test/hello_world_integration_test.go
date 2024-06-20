package test

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
)

const (
	dbDirStage  = "../../stage/data-stores/mysql/"
	appDirStage = "../../stage/services/hello-world-app/"
)

func TestHelloWorldAppStage(t *testing.T) {
	t.Parallel()

	if err := deleteSpecificFilesAndDirs(dbDirStage); err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Specified files and directories deleted successfully.")
	}

	dbOpts := createDbOpts(t, dbDirStage)
	defer terraform.Destroy(t, dbOpts)
	terraform.InitAndApply(t, dbOpts)

	helloOpts := createHelloOpts(dbOpts, appDirStage)
	defer terraform.Destroy(t, helloOpts)
	terraform.InitAndApply(t, helloOpts)

	validateHelloApp(t, helloOpts)
}

func createDbOpts(t *testing.T, terraformDir string) *terraform.Options {
	uniqueId := random.UniqueId()
	bucketTesting := "tf-state-ujstor"
	bucketRegionTesting := "us-east-1"
	dynamodbTable := "terraform-state-locks"

	dbStateKey := fmt.Sprintf("test/%s/%s/terraform.tfstate", t.Name(), uniqueId)

	return &terraform.Options{
		TerraformDir: terraformDir,

		Vars: map[string]interface{}{
			"db_name":     fmt.Sprintf("testdb%s", uniqueId),
			"db_username": "admin",
			"db_password": "password",
		},
		BackendConfig: map[string]interface{}{
			"bucket":         bucketTesting,
			"region":         bucketRegionTesting,
			"key":            dbStateKey,
			"dynamodb_table": dynamodbTable,
			"encrypt":        true,
		},
	}
}

func createHelloOpts(dbOpts *terraform.Options, terraformDir string) *terraform.Options {
	return &terraform.Options{
		TerraformDir: terraformDir,

		Vars: map[string]interface{}{
			"db_remote_state_bucket": dbOpts.BackendConfig["bucket"],
			"db_remote_state_key":    dbOpts.BackendConfig["key"],
			"environment":            dbOpts.Vars["db_name"],
		},

		MaxRetries:         3,
		TimeBetweenRetries: 5 * time.Second,
		RetryableTerraformErrors: map[string]string{
			"RequestError: send request failed": "Throttling issue?",
		},
	}
}

func validateHelloApp(t *testing.T, helloOpts *terraform.Options) {
	albDnsName := terraform.OutputRequired(t, helloOpts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)
	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		url,
		nil,
		maxRetries,
		timeBetweenRetries,
		func(status int, body string) bool {
			return status == 200 &&
				strings.Contains(body, "Hello, World")
		},
	)
}

func deleteSpecificFilesAndDirs(rootDir string) error {
	targets := []string{
		".terraform",
		".terraform.lock.hcl",
	}

	deletePath := func(path string) error {
		fmt.Printf("Deleting: %s\n", path)
		if err := os.RemoveAll(path); err != nil {
			return fmt.Errorf("error deleting %s: %v", path, err)
		}
		return nil
	}

	for _, target := range targets {
		fullPath := filepath.Join(rootDir, target)
		if _, err := os.Stat(fullPath); err == nil {
			if err := deletePath(fullPath); err != nil {
				return err
			}
		} else if !os.IsNotExist(err) {
			return fmt.Errorf("error checking target %s: %v", fullPath, err)
		}
	}

	return nil
}

func TestHelloWorldAppStageWithStages(t *testing.T) {
	t.Parallel()

	stage := test_structure.RunTestStage

	defer stage(t, "teardown_db", func() { teardownDb(t, dbDirStage) })
	stage(t, "deploy_db", func() { deployDb(t, dbDirStage) })

	defer stage(t, "teardown_app", func() { teardownApp(t, appDirStage) })
	stage(t, "deploy_app", func() { deployApp(t, dbDirStage, appDirStage) })

	stage(t, "validate_app", func() { validateApp(t, appDirStage) })
}

func teardownDb(t *testing.T, dbDir string) {
	dbOpts := test_structure.LoadTerraformOptions(t, dbDir)
	defer terraform.Destroy(t, dbOpts)
}

func deployDb(t *testing.T, dbDir string) {
	dbOpts := createDbOpts(t, dbDir)

	test_structure.SaveTerraformOptions(t, dbDir, dbOpts)

	if err := deleteSpecificFilesAndDirs(dbDirStage); err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Specified files and directories deleted successfully.")
	}

	terraform.InitAndApply(t, dbOpts)
}

func teardownApp(t *testing.T, helloAppDir string) {
	helloOpts := test_structure.LoadTerraformOptions(t, helloAppDir)
	defer terraform.Destroy(t, helloOpts)
}

func deployApp(t *testing.T, dbDir string, helloAppDir string) {
	dbOpts := test_structure.LoadTerraformOptions(t, dbDir)
	helloOpts := createHelloOpts(dbOpts, helloAppDir)

	test_structure.SaveTerraformOptions(t, helloAppDir, helloOpts)

	terraform.InitAndApply(t, helloOpts)
}

func validateApp(t *testing.T, helloAppDir string) {
	helloOpts := test_structure.LoadTerraformOptions(t, helloAppDir)
	validateHelloApp(t, helloOpts)
}
