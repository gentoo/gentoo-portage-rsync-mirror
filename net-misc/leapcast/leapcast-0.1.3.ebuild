# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leapcast/leapcast-0.1.3.ebuild,v 1.1 2014/01/24 23:51:41 vapier Exp $

EAPI="4"

inherit distutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/dz0ny/leapcast.git"
	inherit git-2
else
	SRC_URI="https://github.com/dz0ny/leapcast/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="simple ChromeCast emulation app"
HOMEPAGE="https://github.com/dz0ny/leapcast"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="dev-python/requests
	www-servers/tornado"
