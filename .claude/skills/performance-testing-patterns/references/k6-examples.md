# k6 Load Testing Examples

## Stage Design

Structure tests with realistic traffic patterns:

```javascript
export const options = {
  stages: [
    { duration: '2m', target: 10 },   // warm-up
    { duration: '5m', target: 50 },   // normal load
    { duration: '2m', target: 100 },  // peak load
    { duration: '5m', target: 100 },  // sustained peak
    { duration: '2m', target: 200 },  // stress
    { duration: '3m', target: 0 },    // cool-down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
  },
};
```

## Custom Metrics

Define metrics aligned with SLOs:

```javascript
import { Rate, Trend, Counter } from 'k6/metrics';
const errorRate = new Rate('errors');
const responseTime = new Trend('response_time');
const throughput = new Counter('requests_total');
```

## Realistic User Behavior

- Include think time (`sleep(1)`) between requests
- Test critical user journeys end-to-end (login, core action, verification)
- Use `check()` for response validation, not just status codes
