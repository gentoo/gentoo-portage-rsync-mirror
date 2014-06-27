# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/chrome-binary-plugins/chrome-binary-plugins-9999.ebuild,v 1.12 2014/06/26 23:22:20 floppym Exp $

EAPI=4

inherit multilib unpacker

DESCRIPTION="Binary plugins -- native API Flash and PDF -- from Google Chrome for use in Chromium."
HOMEPAGE="http://www.google.com/chrome"
SLOT="unstable"
URI_BASE="https://dl.google.com/linux/direct/"
URI_BASE_NAME="google-chrome-${SLOT}_current_"
SRC_URI="" # URI is left blank on live ebuild

LICENSE="google-chrome"
KEYWORDS="" # KEYWORDS is also left blank on live ebuild
IUSE="+flash +pdf"
RESTRICT="bindist mirror strip"

for x in 0 beta stable unstable; do
	if [[ ${SLOT} != ${x} ]]; then
		RDEPEND+=" !${CATEGORY}/${PN}:${x}"
	fi
done

S="${WORKDIR}/opt/google/chrome-${SLOT}"
QA_PREBUILT="*"

src_unpack() {
	# We have to do this inside of here, since it's a live ebuild. :-(

	if use x86; then
		G_ARCH="i386";
	elif use amd64; then
		G_ARCH="amd64";
	else
		die "This only supports x86 and amd64."
	fi
	wget "${URI_BASE}${URI_BASE_NAME}${G_ARCH}.deb"
	unpack_deb "./${URI_BASE_NAME}${G_ARCH}.deb"
}

src_install() {
	local version flapper

	insinto /usr/$(get_libdir)/chromium-browser/

	use pdf && doins libpdf.so

	if use flash; then
		doins -r PepperFlash

		# Since this is a live ebuild, we're forced to, unfortuantely,
		# dynamically construct the command line args for Chromium.
		version=$(sed -n 's/.*"version": "\(.*\)",.*/\1/p' PepperFlash/manifest.json)
		flapper="${ROOT}usr/$(get_libdir)/chromium-browser/PepperFlash/libpepflashplayer.so"
		echo -n "CHROMIUM_FLAGS=\"\${CHROMIUM_FLAGS} " > pepper-flash
		echo -n "--ppapi-flash-path=$flapper " >> pepper-flash
		echo "--ppapi-flash-version=$version\"" >> pepper-flash

		insinto /etc/chromium/
		doins pepper-flash
	fi
}
