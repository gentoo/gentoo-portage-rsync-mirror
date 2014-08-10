# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Fortune/PEAR-File_Fortune-1.0.0.ebuild,v 1.3 2014/08/10 20:46:50 slyfox Exp $

inherit php-pear-r1

DESCRIPTION="Interface for reading from and writing to fortune files"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/php-5.1.4"
RDEPEND="${DEPEND}"
