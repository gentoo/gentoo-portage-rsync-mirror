# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/chrome-binary-plugins/chrome-binary-plugins-34.0.1847.14_beta1.ebuild,v 1.1 2014/02/28 01:17:47 floppym Exp $

EAPI=4

inherit multilib unpacker

DESCRIPTION="Binary plugins -- native API Flash and PDF -- from Google Chrome for use in Chromium."
HOMEPAGE="http://www.google.com/chrome"

case ${PV} in
	*_alpha*)
		SLOT="unstable"
		MY_PV=${PV/_alpha/-}
		;;
	*_beta*)
		SLOT="beta"
		MY_PV=${PV/_beta/-}
		;;
	*_p*)
		SLOT="stable"
		MY_PV=${PV/_p/-}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac

MY_PN="google-chrome-${SLOT}"
MY_P="${MY_PN}_${MY_PV}"

SRC_URI="
	amd64? (
		http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_amd64.deb
	)
	x86? (
		http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_i386.deb
	)
"

LICENSE="google-chrome"
KEYWORDS="~amd64 ~x86"
IUSE="+flash +pdf"
RESTRICT="bindist mirror strip"

RDEPEND="www-client/chromium"

for x in 0 beta stable unstable; do
	if [[ ${SLOT} != ${x} ]]; then
		RDEPEND+=" !${CATEGORY}/${PN}:${x}"
	fi
done

S="${WORKDIR}/opt/google/chrome-${SLOT}"
QA_PREBUILT="*"

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
