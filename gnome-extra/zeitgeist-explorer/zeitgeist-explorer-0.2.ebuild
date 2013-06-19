# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist-explorer/zeitgeist-explorer-0.2.ebuild,v 1.1 2013/06/19 06:20:46 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 versionator

MY_PV="$(get_version_component_range 1-2)"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Monitor and inspect Zeitgeist's log at a low level - developer tool"
HOMEPAGE="https://launchpad.net/zeitgeist-explorer/"
SRC_URI="https://launchpad.net/${PN}/0.x/${MY_PV}/+download/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	gnome-extra/zeitgeist
	x11-libs/gtk+:3[introspection]"
DEPEND="${RDEPEND}
	dev-python/python-distutils-extra"

DISTUTILS_NO_PARALLEL_BUILD=true
