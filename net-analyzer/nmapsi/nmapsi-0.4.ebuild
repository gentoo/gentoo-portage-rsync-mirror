# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmapsi/nmapsi-0.4.ebuild,v 1.2 2013/03/02 22:46:17 hwoarang Exp $

EAPI=5

PLOCALES="ca cs de es fr it ru"

inherit cmake-utils l10n

MY_P=${PN}4-${PV}

DESCRIPTION="A Qt4 frontend to nmap"
HOMEPAGE="http://www.nmapsi4.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
	kde? ( kde-base/kdelibs:4 )
"
RDEPEND="${DEPEND}
	>=net-analyzer/nmap-6.00
	net-dns/bind-tools
"

S=${WORKDIR}/${MY_P}

DOCS=(AUTHORS HACKING NEWS TODO Translation)

src_prepare() {
	l10n_for_each_disabled_locale_do nmapsi_disable_locale
}

nmapsi_disable_locale() {
	sed -i -e "/ts\/${PN}4_${1}\.ts/d" src/CMakeLists.txt || die
}
