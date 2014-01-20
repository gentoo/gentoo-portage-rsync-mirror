# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Manifest/ExtUtils-Manifest-1.580.0.ebuild,v 1.5 2014/01/20 20:58:11 vapier Exp $

EAPI=2

MODULE_AUTHOR=RKOBES
MODULE_VERSION=1.58
inherit perl-module

DESCRIPTION="Utilities to write and check a MANIFEST file"

SLOT="0"
KEYWORDS="alpha amd64 ~arm arm64 hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
PREFER_BUILDPL="no"
