package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAlbExample(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir: "../examples/alb",
		Vars: map[string]interface{}{
			"alb_name": fmt.Sprintf("test-alb-%s", random.UniqueId()),
		},
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	albDnsName := terraform.OutputRequired(t, opts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)

	expectedStatus := 404
	expectedBody := "404: page not found"
	maxRetries := 10
	opts.TimeBetweenRetries = 10 * time.Second

	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,
		expectedStatus,
		expectedBody,
		maxRetries,
		opts.TimeBetweenRetries,
	)
}
