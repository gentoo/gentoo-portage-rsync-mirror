# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-Libwrap/Authen-Libwrap-0.220.0-r1.ebuild,v 1.1 2014/08/26 18:16:55 axs Exp $

EAPI=5

MODULE_AUTHOR=DMUEY
MODULE_VERSION=0.22
inherit perl-module

DESCRIPTION="A Perl access to the TCP Wrappers interface"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="sys-apps/tcp-wrappers"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Exception
		dev-perl/Test-Pod
	)"

SRC_TEST="do"
