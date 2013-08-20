# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nanomsg/nanomsg-0.1.ebuild,v 1.1 2013/08/20 08:56:16 djc Exp $

EAPI=5

DESCRIPTION="High-performance messaging interface for distributed applications"
HOMEPAGE="http://nanomsg.org/"
SRC_URI="http://download.nanomsg.org/${P}-alpha.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}-alpha"
