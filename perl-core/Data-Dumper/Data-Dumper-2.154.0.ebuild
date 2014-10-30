# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Data-Dumper/Data-Dumper-2.154.0.ebuild,v 1.10 2014/10/30 18:54:18 maekke Exp $

EAPI=5

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=2.154
inherit perl-module

DESCRIPTION="Stringified perl data structures, suitable for both printing and eval"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"
