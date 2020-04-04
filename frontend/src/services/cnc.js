const cnc = {};

const handleResponse = async response => {
  if (!response.ok || response.status === 404) {
    if (response.status !== 404) {
      try {
        const err = await response.json();
        console.error(`${err.message} (${err.statusCode})` || response.statusText);
      } catch (e) {
        console.error(response.statusText);
      }
    }
    return;
  }
  return response.json();
};

const send = (path, method, payload) => fetch(`${path}`, {
  method,
  headers: {
    'Content-Type': 'application/json',
  },
  ...(payload ? {body: JSON.stringify(payload)} : {}),
}).then(handleResponse);

cnc.login = (payload) => {
  send('/login', 'POST', payload)
    .then((res) => Promise.resolve(res))
};

export default cnc;
