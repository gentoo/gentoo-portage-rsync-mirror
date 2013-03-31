# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/npapi-sdk/npapi-sdk-0.27.2.ebuild,v 1.9 2013/03/31 10:38:00 ago Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="NPAPI headers bundle"
HOMEPAGE="https://bitbucket.org/mgorny/npapi-sdk/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/pkgconfig"
