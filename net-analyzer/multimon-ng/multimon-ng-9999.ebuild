# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/multimon-ng/multimon-ng-9999.ebuild,v 1.2 2013/06/28 20:40:28 zerochaos Exp $

EAPI=5

inherit qt4-r2

DESCRIPTION="a fork of multimon, decodes multiple digital transmission modes"
HOMEPAGE="https://github.com/EliasOenal/multimonNG"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/EliasOenal/multimonNG.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/EliasOenal/multimonNG/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/multimonNG-${PV}
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="media-sound/pulseaudio
	x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN}
}
