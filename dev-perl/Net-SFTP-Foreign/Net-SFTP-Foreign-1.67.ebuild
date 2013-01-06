# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SFTP-Foreign/Net-SFTP-Foreign-1.67.ebuild,v 1.1 2012/10/29 08:04:15 patrick Exp $

EAPI=4

MODULE_AUTHOR=SALVA
MODULE_VERSION=1.67
inherit perl-module

DESCRIPTION="Net::SFTP::Foreign, Secure File Transfer Protocol client"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="perl-core/ExtUtils-MakeMaker
	     perl-core/Test-Simple"
DEPEND="${RDEPEND}"
