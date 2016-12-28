const fs = require('fs');

if (!process.argv[2]) {
	console.error('please specify a filename.');
	process.exit(1);
}

const data = JSON.parse(fs.readFileSync(process.argv[2]));

data.forEach((elem) => {

	if (elem.extension.toString().length !== 4 ||
		elem.extension >= 9000 || elem.extension < 2000) {
		return;
	}
	
	if (elem.phone_type != 5) {
		return;
	}

	console.log(elem.extension);

});

