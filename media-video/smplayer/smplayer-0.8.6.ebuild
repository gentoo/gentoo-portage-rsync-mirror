# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.8.6.ebuild,v 1.1 2013/08/18 11:26:16 yngwin Exp $

EAPI=5
PLOCALES="ar_SY bg ca cs da de el_GR en_US es et eu fi fr gl he_IL hr hu it ja
ka ko ku lt mk ms_MY nl pl pt pt_BR ro_RO ru_RU sk sl_SI sr sv th tr uk_UA vi_VN
zh_CN zh_TW"
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
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
MPLAYER_USE="[libass,png,X]"
RDEPEND="${DEPEND}
	|| ( media-video/mplayer${MPLAYER_USE} media-video/mplayer2${MPLAYER_USE} )"

src_prepare() {
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

	# Turn off online update checker, bug #479902
	sed -e 's:DEFINES += UPDATE_CHECKER:#DEFINES += UPDATE_CHECKER:' \
		-i "${S}"/src/smplayer.pro || die "sed failed"

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
	# remove unneeded copies of licenses
	rm -f Copying* docs/{cs,en,hu,it,ja,pt,ru,zh_CN}/gpl.html || die
	rm -rf docs/{de,es,fr,nl,ro} || die

	emake DESTDIR="${D}" install
}
