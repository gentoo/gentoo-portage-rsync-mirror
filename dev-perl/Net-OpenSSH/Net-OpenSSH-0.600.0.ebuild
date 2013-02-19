# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-OpenSSH/Net-OpenSSH-0.600.0.ebuild,v 1.1 2013/02/19 16:02:08 tove Exp $

EAPI=5

MODULE_AUTHOR=SALVA
MODULE_VERSION=0.60
inherit perl-module

DESCRIPTION="Net::OpenSSH, Perl wrapper for OpenSSH secure shell client"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="sftp"

RDEPEND="
	dev-perl/IO-Tty
	sftp? (
		dev-perl/Net-SFTP-Foreign
	)
"
DEPEND="${RDEPEND}"

#SRC_TEST=do
