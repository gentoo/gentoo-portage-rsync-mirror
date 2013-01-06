# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.7.1-r1.ebuild,v 1.11 2013/01/01 11:33:27 ago Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit autotools python

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="alsa ao +espeak flite nas pulseaudio python"

RDEPEND="dev-libs/dotconf
	>=dev-libs/glib-2
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	espeak? ( app-accessibility/espeak )
	flite? ( app-accessibility/flite )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	# Disable byte-compilation of Python modules.
	echo "#!/bin/sh" > py-compile

	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS += python/d" -i src/Makefile.am

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable python) \
		$(use_with alsa) \
		$(use_with ao libao) \
		$(use_with espeak) \
		$(use_with flite) \
		$(use_with pulseaudio pulse) \
		$(use_with nas)
}

src_compile() {
	emake all || die

	if use python; then
		python_copy_sources src/python

		building() {
			emake \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir src/python building
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir src/python installation
	fi

	dodoc AUTHORS NEWS TODO
	local f
	for f in clibrary clibrary2 connection_recovery long_message run_test; do
		rm "${D}"/usr/bin/${f}
	done
}

pkg_postinst() {
	use python && python_mod_optimize speechd speechd_config

	local editconfig="n"
	if ! use espeak; then
		ewarn "You have disabled espeak, which is speech-dispatcher's"
		ewarn "default speech synthesizer."
		ewarn
		editconfig="y"
	fi
	if ! use pulseaudio; then
		ewarn "You have disabled pulseaudio support."
		ewarn "pulseaudio is speech-dispatcher's default audio subsystem."
		ewarn
		editconfig="y"
	fi
	if [[ "${editconfig}" == "y" ]]; then
		ewarn "You must edit ${EROOT}etc/speech-dispatcher/speechd.conf"
		ewarn "and make sure the settings there match your system."
		ewarn
	fi
	ewarn "This version does not include a system wide startup script"
	ewarn "since it is not intended to be run in system-wide mode."
	ewarn
	elog "For festival support, you need to"
	elog "install app-accessibility/festival-freebsoft-utils."
}

pkg_postrm() {
	use python && python_mod_cleanup speechd speechd_config
}
