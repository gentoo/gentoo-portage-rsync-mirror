# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgbadger/pgbadger-3.5.ebuild,v 1.1 2013/07/22 00:53:21 titanofold Exp $

EAPI=5

inherit perl-app

DESCRIPTION="pgBadger is a PostgreSQL log analyzer."
HOMEPAGE="http://dalibo.github.io/pgbadger/"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Text-CSV_XS"
RDEPEND="${DEPEND}"
