# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Validate-IP/Data-Validate-IP-0.240.0.ebuild,v 1.5 2015/02/02 14:41:58 jer Exp $

EAPI=5

MODULE_AUTHOR="DROLSKY"
MODULE_VERSION="0.24"

inherit perl-module

DESCRIPTION="Lightweight IPv4 and IPv6 validation module"

SLOT="0"
KEYWORDS="amd64 ~hppa"
IUSE="test"

RDEPEND="
	virtual/perl-Exporter
	>=dev-perl/NetAddr-IP-4
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-File-Spec
		virtual/perl-IO
		>=virtual/perl-Test-Simple-0.880.0
		dev-perl/Test-Requires
	)
"

SRC_TEST=do
