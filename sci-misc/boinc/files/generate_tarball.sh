#!/usr/bin/env bash
## $Id: generate_tarball.sh,v 1.2 2011/05/22 09:22:59 scarabeus Exp $
## Modified by scarabeus 2008-10-23
###############################################################################
# functions
###############################################################################
# print out help function
help() {
	echo "Welcome to Boinc tarball generator"
	echo
	echo "For correct usage set VERSION argument"
	echo "Example:"
	echo "$0 -v 6.1.1"
	exit 0
}
###############################################################################
# argument passing
###############################################################################
if [[ $1 == "--help" ]]; then
	help
fi
while getopts v: arg ; do
	case $arg in
		v) VERSION=${OPTARG};;
		*) help;;
	esac
done
if [ -z "${VERSION}" ]; then
	help
fi
###############################################################################
# variable definition
###############################################################################
SVN_URI="http://boinc.berkeley.edu/svn/tags/boinc_core_release_${VERSION//./_}"
PACKAGE="boinc-${VERSION}"
BUNDLE_PREFIX="boinc-dist"
LOG=linux.log
###############################################################################
# prepare enviroment
###############################################################################
mkdir ${BUNDLE_PREFIX} -p
rm -rf "${BUNDLE_PREFIX}"/* # CLEANUP
cd "${BUNDLE_PREFIX}"
touch "${LOG}"
echo "" > "${LOG}"	# LOG CLEANUP
###############################################################################
# get data from svn
###############################################################################
echo "<Downloading files from SVN repository>"
echo "<******************************>"
svn export ${SVN_URI} ${PACKAGE} >> "${LOG}"
###############################################################################
# cleanup files we fetched
###############################################################################
echo "<Cleaning up data we fetched>"
echo "<******************************>"
pushd "${PACKAGE}" > /dev/null

# First remove NON Linux stuff we will not use
rm -rf mac_installer/ # mac installer scripts
rm -rf clientgui/mac/ # mac windows
rm -rf clientscr/ # windows screensaver
rm -rf clienttray/ # windows systray
rm -rf win_build/ # windows build stuff
rm -rf clientlib/ # only windows stuff
rm -rf client/os2/ # OS2 stuff
rm -rf client/win/ # windows stuff
rm -rf mac_build/ # mac build scripts
rm -rf RSAEuro/ # empty folder
rm -rf html/ # webpages WTF?


# BUNDLED STUFF NEEDED REMOVAL
rm -rf coprocs/ # CUDA
rm -rf curl/
#rm -rf locale/*/*.mo # translations should be generated on user machines
# Actualy they dont generate them
rm -rf zlib/
rm -rf openssl/

popd > /dev/null

###############################################################################
# create tbz
###############################################################################
tar cJf "${PACKAGE}".tar.xz ${PACKAGE} >> "${LOG}"
find ./ -maxdepth 1 -type f -name \*.tar.xz -print | while read FILE ; do
	echo "FILE: ${FILE}"
	echo "      SIZE: $(`which du` -h ${FILE} |`which awk` -F' ' '{print $1}')"
	echo "    MD5SUM: $(`which md5sum` ${FILE} |`which awk` -F' ' '{print $1}')"
	echo "   SHA1SUM: $(`which sha1sum` ${FILE} |`which awk` -F' ' '{print $1}')"
	echo
done
echo "<<<All done>>>"
###############################################################################
