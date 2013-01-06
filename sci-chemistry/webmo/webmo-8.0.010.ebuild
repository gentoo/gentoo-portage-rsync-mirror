# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/webmo/webmo-8.0.010.ebuild,v 1.5 2011/06/27 05:30:11 jlec Exp $

inherit eutils webapp depend.apache

MY_SRC_PN="WebMO"
MY_SRC_P="${MY_SRC_PN}.${PV}"
DESCRIPTION="Web-based interface to computational chemistry packages"
HOMEPAGE="http://webmo.net/"
SRC_URI="${MY_SRC_P}.tar.gz"

LICENSE="WebMO"
SLOT="${PVR}"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
need_apache2

RESTRICT="fetch"

S="${WORKDIR}/${MY_SRC_PN}.install"

pkg_setup() {
	webapp_pkg_setup
}

pkg_nofetch() {
	einfo "Go to http://webmo.net/ and register for a free license."
	einfo "Download ${SRC_URI} and place it in ${DISTDIR}."
}

src_unpack() {
	# We need a license number to proceed
	if [[ -z ${WEBMO_LICENSE} ]]; then
		msg="You must set WEBMO_LICENSE to your license number in make.conf."
		ewarn "$msg"
		die "$msg"
	fi

	# Check for invalid license values. Valid are dddd-dddd-dddd
	if [[ ${WEBMO_LICENSE} != [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] ]]; then
		msg="Invalid license format. Licenses should be DDDD-DDDD-DDDD (D is a digit)."
		ewarn "$msg"
		die "$msg"
	fi

	unpack ${A}

	# Set up program locations to match where portage installs them
	epatch "${FILESDIR}"/8.0.010-gentoo-locations.patch

	# Add a data directory for gamess, because WebMO expects everything
	# in one directory instead of FHS
	# (Depends on gentoo-locations.patch)
	epatch "${FILESDIR}"/8.0.010-add-gamess-data-directory.patch

	# Don't run diagnose.pl or ask about being root user
	epatch "${FILESDIR}"/dont-be-interactive-or-diagnose.patch

	# Make setup.conf
	create_setup_conf
}

src_install() {
	webapp_src_preinst

	# Install everything
	perl setup.pl || die "Check '${S}'/diagnose.html for errors"

	# Get ${D} out of main config file
	dosed "${MY_CGIBINDIR}/webmo/interfaces/globals.int"

	webapp_hook_script "${FILESDIR}"/reconfig

	local files=$(find "${D}"${MY_HOSTROOTDIR}/webmo "${D}"${MY_CGIBINDIR}/webmo/interfaces)
	# Add the directories themselves
	files="${files} ${MY_HOSTROOTDIR}/webmo ${MY_CGIBINDIR}/webmo/interfaces"
	files=${files//${D}/}
	for file in ${files}; do
		webapp_configfile "${file}"
		webapp_serverowned "${file}"
	done

	ebegin "Fixing permissions"
	pushd "${D}" > /dev/null
	find . -perm /o+w -type f | xargs fperms 664
	find . -perm /o+w -type d | xargs fperms 775
	popd > /dev/null
	eend 0

	webapp_src_install
}

pkg_postinst() {
	elog
	elog "Be sure that this line is uncommented in httpd.conf:"
	elog "AddHandle cgi-scripts .cgi"
	elog
	elog "The diagnose.pl script can be run if WebMO doesn't work properly."
	elog
	ewarn "Be careful never to overwrite your user, group or job databases"
	ewarn "when using etc-update after an upgrade."

	webapp_pkg_postinst
}

create_setup_conf() {
	local SETUP_CONF="${S}/setup.conf"

	echo_setup perlPath /usr/bin/perl "${SETUP_CONF}"
	echo_setup htmlBase "${D}${MY_HTDOCSDIR}" "${SETUP_CONF}"
	echo_setup url_htmlBase /webmo "${SETUP_CONF}"
	echo_setup cgiBase "${D}${MY_CGIBINDIR}/webmo" "${SETUP_CONF}"
	echo_setup url_cgiBase /cgi-bin/webmo "${SETUP_CONF}"
	echo_setup userBase "${D}${MY_HOSTROOTDIR}/webmo" "${SETUP_CONF}"
	echo_setup license "${WEBMO_LICENSE}" "${SETUP_CONF}"
}

# Takes three arguments:
# 1: variable, 2: value, 3: file to echo them to
echo_setup() {
	# All values must be double-quoted, so escape the inner quotes.
	echo "${1}=\"${2}\"" >> ${3}
}
