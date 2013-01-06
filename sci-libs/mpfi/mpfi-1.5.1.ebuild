# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mpfi/mpfi-1.5.1.ebuild,v 1.1 2012/02/06 01:00:26 bicatali Exp $

EAPI="4"

inherit autotools-utils

PID=30129

DESCRIPTION="Multiple precision interval arithmetic library based on MPFR"
HOMEPAGE="http://perso.ens-lyon.fr/nathalie.revol/software.html"
SRC_URI="https://gforge.inria.fr/frs/download.php/${PID}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DEPEND=">=dev-libs/gmp-4.1.2
	>=dev-libs/mpfr-2.4"
RDEPEND="${DEPEND}"
