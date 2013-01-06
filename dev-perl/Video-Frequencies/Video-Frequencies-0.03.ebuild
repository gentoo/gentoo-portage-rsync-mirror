# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Video-Frequencies/Video-Frequencies-0.03.ebuild,v 1.11 2008/03/20 17:44:30 beandog Exp $

inherit perl-module

DESCRIPTION="Video Frequencies perl module, for use with ivtv-ptune"
HOMEPAGE="http://ivtv.sourceforge.net"
SRC_URI="mirror://sourceforge/ivtv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

export OPTIMIZE="$CFLAGS"
mydoc="README"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
