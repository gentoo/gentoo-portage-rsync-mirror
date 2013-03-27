# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.8.ebuild,v 1.1 2013/03/27 15:07:53 neurogeek Exp $

EAPI=5
PYTHON_COMPAT=( python3_2 pypy{1_9,2_0} )

inherit autotools-utils python-r1

DESCRIPTION="Speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa ao +espeak flite nas pulseaudio python static-libs"

RDEPEND=">=dev-libs/glib-2.28:2
	>=media-libs/libsndfile-1.0.2
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	espeak? ( app-accessibility/espeak )
	flite? ( app-accessibility/flite )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	>=dev-libs/dotconf-1.3
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig"

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
			cd src/api/python || die
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
			cd src/api/python || die
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_foreach_impl run_in_build_dir installation
		python_replicate_script "${ED}"/usr/bin/spd-conf
	fi
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
	elog "For festival support, you need to"
	elog "install app-accessibility/festival-freebsoft-utils."
}
