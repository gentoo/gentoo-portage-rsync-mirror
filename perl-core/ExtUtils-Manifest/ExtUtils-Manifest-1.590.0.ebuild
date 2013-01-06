# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Manifest/ExtUtils-Manifest-1.590.0.ebuild,v 1.2 2012/02/04 15:27:34 armin76 Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=1.59
inherit perl-module

DESCRIPTION="Utilities to write and check a MANIFEST file"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"
PREFER_BUILDPL="no"
