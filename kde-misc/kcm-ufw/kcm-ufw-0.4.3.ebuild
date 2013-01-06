# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm-ufw/kcm-ufw-0.4.3.ebuild,v 1.2 2012/06/14 19:42:36 thev00d00 Exp $

EAPI=4

PYTHON_DEPEND="2"
inherit python kde4-base

MY_P="${P/-/_}"

DESCRIPTION="KCM module to control the Uncomplicated Firewall"
HOMEPAGE="http://kde-apps.org/content/show.php?content=137789"
SRC_URI="http://craigd.wikispaces.com/file/view/${MY_P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

LINGUAS="en es fr lt"
for lingua in ${LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

COMMON_DEPEND="
	>=net-firewall/ufw-0.31
	sys-auth/polkit-kde-agent
"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdebase_dep kcmshell)
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_pkg_setup
	kde4-base_pkg_setup
}

src_configure() {
	LANGS=""
	for x in ${LINGUAS}; do
		use linguas_${x} && LANGS+="${x};"
	done
	MYCMAKEARGS="-DUFW_TRANSLATIONS=${LANGS}"
	kde4-base_src_configure
}
