# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustal-omega/clustal-omega-1.0.3.ebuild,v 1.1 2011/09/25 22:35:59 weaver Exp $

EAPI=4

DESCRIPTION="Scalable multiple alignment of protein sequences"
HOMEPAGE="http://www.clustal.org/omega/"
SRC_URI="http://www.clustal.org/omega/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/argtable"
RDEPEND="${DEPEND}"
