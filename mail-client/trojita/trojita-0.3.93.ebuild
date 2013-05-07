# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-0.3.93.ebuild,v 1.1 2013/05/07 08:14:42 ago Exp $

EAPI=4

QT_REQUIRED="4.6.0"
EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"
[[ ${PV} == "9999" ]] && GIT_ECLASS="git-2"
inherit qt4-r2 virtualx ${GIT_ECLASS}

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"
if [[ ${PV} == "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~ppc ~x86"
	MY_LANGS="bs cs da de el es et fr ga gl hu ia lt mr nl pl pt pt_BR sk sv tr uk zh_CN zh_TW"
fi

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
IUSE="debug test +zlib"
for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
done

RDEPEND="
	>=dev-qt/qtgui-${QT_REQUIRED}:4
	>=dev-qt/qtsql-${QT_REQUIRED}:4[sqlite]
	>=dev-qt/qtwebkit-${QT_REQUIRED}:4
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qttest-${QT_REQUIRED}:4 )
	zlib? (
		virtual/pkgconfig
		sys-libs/zlib
	)
"

src_configure() {
	local myopts=""
	use debug && myopts="$myopts CONFIG+=debug"
	use test || myopts="$myopts CONFIG+=disable_tests"
	use zlib || myopts="$myopts CONFIG+=disable_zlib"
	if [[ ${MY_LANGS} ]]; then
		rm po/trojita_common_x-test.po
		for x in po/*.po; do
			mylang=${x#po/trojita_common_}
			mylang=${mylang%.po}
			use linguas_$mylang || rm $x
		done
	fi

	eqmake4 PREFIX=/usr $myopts
}

src_test() {
	Xemake test
}
