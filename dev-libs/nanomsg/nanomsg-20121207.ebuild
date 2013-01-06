# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nanomsg/nanomsg-20121207.ebuild,v 1.1 2012/12/07 05:12:49 patrick Exp $

EAPI=4

RESTRICT="test" # funky failures

DESCRIPTION="High-performance messaging interface for distributed applications"
HOMEPAGE="https://github.com/250bpm/nanomsg"
SRC_URI="http://dev.gentooexperimental.org/~dreeevil/${P}.zip"

inherit eutils cmake-utils

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-master"
