# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_QuickForm2/PEAR-HTML_QuickForm2-2.0.0.ebuild,v 1.2 2014/08/10 20:48:31 slyfox Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="The PEAR::HTML_QuickForm package provides methods for creating, validating, processing HTML forms"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/php-5.2.0"
RDEPEND="${DEPEND}
	>=dev-php/PEAR-HTML_Common2-2.0.0"
