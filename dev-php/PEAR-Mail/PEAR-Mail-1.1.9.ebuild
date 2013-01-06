# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Mail/PEAR-Mail-1.1.9.ebuild,v 1.17 2007/12/06 00:32:55 jokey Exp $

inherit php-pear-r1

DESCRIPTION="Class that provides multiple interfaces for sending emails"

LICENSE="PHP-2.02 BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Net_SMTP-1.2.7"
