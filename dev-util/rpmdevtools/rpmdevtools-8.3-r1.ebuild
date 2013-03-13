# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rpmdevtools/rpmdevtools-8.3-r1.ebuild,v 1.1 2013/03/13 00:02:49 sochotnicky Exp $

EAPI=4

DESCRIPTION="Collection of rpm packaging related utilities"
HOMEPAGE="https://fedorahosted.org/rpmdevtools/"
SRC_URI="https://fedorahosted.org/releases/r/p/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

CDEPEND="
	app-arch/rpm[python]
	net-misc/curl
	emacs? ( app-emacs/rpm-spec-mode )
	dev-util/checkbashisms
"

DEPEND="
	${CDEPEND}
	dev-lang/perl
	sys-apps/help2man
"

RDEPEND="${CDEPEND}"

src_install() {
	default

	rm "${ED}/usr/bin/checkbashisms" || die "Failed to remove checkbashisms script"
}
