# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.8.3.ebuild,v 1.2 2013/01/16 19:13:40 yngwin Exp $

EAPI=4
PLOCALES="ar_SY bg ca cs da de el_GR en_US es et eu fi fr gl hr hu it ja ka ko
ku lt mk nl pl pt pt_BR ro_RO ru_RU sk sl_SI sr sv tr uk_UA vi_VN zh_CN zh_TW"
PLOCALE_BACKUP="en_US"

inherit eutils l10n qt4-r2

MY_PV=${PV##*_p}
if [[ "${MY_PV}" != "${PV}" ]]; then
	# svn snapshot
	MY_PV=r${MY_PV}
	MY_P=${PN}-${MY_PV}
	S="${WORKDIR}/${MY_P}"
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
else
	# regular upstream release
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
fi

DESCRIPTION="Great Qt4 GUI front-end for mplayer"
HOMEPAGE="http://smplayer.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	dev-libs/quazip"
MPLAYER_USE="[libass,png,X]"
RDEPEND="${DEPEND}
	|| ( media-video/mplayer2${MPLAYER_USE} media-video/mplayer${MPLAYER_USE} )"

src_prepare() {
	# Unbundle dev-libs/quazip
	rm -R src/findsubtitles/quazip/ || die
	epatch "${FILESDIR}"/${PN}-0.8.0-quazip.patch

	# Upstream Makefile sucks
	sed -i -e "/^PREFIX=/s:/usr/local:/usr:" \
		-e "/^DOC_PATH=/s:packages/smplayer:${PF}:" \
		-e '/\.\/get_svn_revision\.sh/,+2c\
	cd src && $(DEFS) $(MAKE)' \
		"${S}"/Makefile || die "sed failed"

	# Turn debug message flooding off
	if ! use debug ; then
		sed -i 's:#\(DEFINES += NO_DEBUG_ON_CONSOLE\):\1:' \
			"${S}"/src/smplayer.pro || die "sed failed"
	fi

	# l10n_find_plocales_changes "${S}/src/translations" "${PN}_" '.ts'
}

src_configure() {
	cd "${S}"/src
	echo "#define SVN_REVISION \"SVN-${MY_PV} (Gentoo)\"" > svn_revision.h
	eqmake4
}

gen_translation() {
	ebegin "Generating $1 translation"
	lrelease ${PN}_${1}.ts
	eend $? || die "failed to generate $1 translation"
}

src_compile() {
	emake

	cd "${S}"/src/translations
	l10n_for_each_locale_do gen_translation
}

src_install() {
	# remove unneeded copies of GPL
	rm -f Copying.txt docs/{cs,en,hu,it,ja,pt,ru,zh_CN}/gpl.html || die
	rm -rf docs/{de,es,nl,ro} || die

	emake DESTDIR="${D}" install
}
