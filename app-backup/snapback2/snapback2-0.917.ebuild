# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/snapback2/snapback2-0.917.ebuild,v 1.1 2011/08/30 08:57:41 patrick Exp $

inherit perl-module

MY_P=Snapback2-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Snapback2 does backup of systems via ssh and rsync. It creates roll
ing ``snapshots'' based on hourly, daily, weekly, and monthly rotations."
SRC_URI="mirror://cpan/authors/id/M/MI/MIKEH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mikeh"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Config-ApacheFormat"
