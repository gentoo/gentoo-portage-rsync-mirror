# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/egypt/egypt-1.9-r1.ebuild,v 1.1 2013/09/01 15:12:50 idella4 Exp $

EAPI=5

inherit perl-module

DESCRIPTION="devilishly simple tool for creating call graphs of C programs"
HOMEPAGE="http://www.gson.org/egypt/"
SRC_URI="http://www.gson.org/egypt/download/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
