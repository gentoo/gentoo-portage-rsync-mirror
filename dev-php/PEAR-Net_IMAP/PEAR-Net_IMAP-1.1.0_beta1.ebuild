# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_IMAP/PEAR-Net_IMAP-1.1.0_beta1.ebuild,v 1.10 2007/12/06 00:40:17 jokey Exp $

PEAR_PV="${PV/_/}"

inherit php-pear-r1

DESCRIPTION="Provides an implementation of the IMAP protocol."

LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.6-r1"
