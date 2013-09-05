# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.7.1-r2.ebuild,v 1.4 2013/09/05 14:39:40 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils python-r1

DESCRIPTION="Speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa ao +espeak flite nas pulseaudio python static-libs"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/dotconf
	>=dev-libs/glib-2
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	espeak? ( app-accessibility/espeak )
	flite? ( app-accessibility/flite )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-pthread.patch
	"${FILESDIR}"/${P}-gold.patch
	)

src_prepare() {
	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS += python/d" -i src/Makefile.am || die

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable python)
		$(use_with alsa)
		$(use_with ao libao)
		$(use_with espeak)
		$(use_with flite)
		$(use_with pulseaudio pulse)
		$(use_with nas)
		)
	autotools-utils_src_configure
}

src_compile() {
	use python && python_copy_sources

	autotools-utils_src_compile all

	if use python; then
		building() {
			cd src/python || die
			emake \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)"
		}
		python_foreach_impl run_in_build_dir building
	fi
}

src_install() {
	autotools-utils_src_install

	if use python; then
		installation() {
			cd src/python || die
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_foreach_impl run_in_build_dir installation
		python_replicate_script "${ED}"/usr/bin/spd-conf
	fi

	local f
	for f in clibrary clibrary2 connection_recovery long_message run_test; do
		rm "${ED}"/usr/bin/${f} || die
	done
}

pkg_postinst() {
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
