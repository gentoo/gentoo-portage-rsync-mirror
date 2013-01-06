# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.64.ebuild,v 1.2 2009/11/25 00:06:41 vapier Exp $

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	ftp://alpha.gnu.org/pub/gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2.5"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="emacs"

DEPEND=">=sys-apps/texinfo-4.3
	>=sys-devel/m4-1.4.6
	dev-lang/perl"
RDEPEND="${DEPEND}
	>=sys-devel/autoconf-wrapper-7"
PDEPEND="emacs? ( app-emacs/autoconf-mode )"

src_compile() {
	# Disable Emacs in the build system since it is in a separate package.
	export EMACS=no
	econf --program-suffix="-${PV}" || die
	# econf updates config.{sub,guess} which forces the manpages
	# to be regenerated which we dont want to do #146621
	touch man/*.1
	# From configure output:
	# Parallel builds via `make -jN' do not work.
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS NEWS README TODO THANKS \
		ChangeLog ChangeLog.0 ChangeLog.1 ChangeLog.2
}
