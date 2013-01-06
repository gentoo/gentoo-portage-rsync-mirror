# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-OpenSSH/Net-OpenSSH-0.52.ebuild,v 1.1 2012/10/29 08:03:28 patrick Exp $

EAPI=4

MODULE_AUTHOR=SALVA
MODULE_VERSION=0.52
inherit perl-module

DESCRIPTION="Net::OpenSSH, Perl wrapper for OpenSSH secure shell client"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="sftp"

RDEPEND="virtual/perl-Test-Simple
	     dev-perl/IO-Tty
		 sftp? ( dev-perl/Net-SFTP-Foreign )"
DEPEND="${RDEPEND}"
