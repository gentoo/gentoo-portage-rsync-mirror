# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Math_BigInteger/PEAR-Math_BigInteger-1.0.2.ebuild,v 1.3 2014/11/07 13:59:54 grknight Exp $

EAPI=5

inherit php-pear-r1

DESCRIPTION="Pure-PHP arbitrary precision integer arithmetic library"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND=">=dev-lang/php-5.3.0"
