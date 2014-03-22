# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/portspoof/portspoof-9999.ebuild,v 1.1 2014/03/22 22:51:32 zerochaos Exp $

EAPI=5

DESCRIPTION="return SYN+ACK for every port connection attempt"
HOMEPAGE="http://portspoof.org/"
LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://github.com/drk1wi/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/drk1wi/portspoof/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		eautoreconf
	fi
}
