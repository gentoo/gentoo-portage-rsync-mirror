# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-DigestMD5/Authen-DigestMD5-0.40.0.ebuild,v 1.2 2011/09/03 21:04:37 tove Exp $

EAPI=4

MODULE_AUTHOR=SALVA
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="SASL DIGEST-MD5 authentication (RFC2831)"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="$CFLAGS"
