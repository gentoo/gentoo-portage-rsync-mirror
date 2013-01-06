# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/air/air-1.2.8-r1.ebuild,v 1.2 2009/11/24 14:54:45 flameeyes Exp $

DESCRIPTION="A GUI front-end to dd/dcfldd"
HOMEPAGE="http://air-imager.sourceforge.net/"
SRC_URI="mirror://sourceforge/air-imager/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-perl/perl-tk-804.027
	userland_GNU? ( app-arch/sharutils )
	sys-apps/sed
	dev-lang/perl"

RDEPEND="app-arch/mt-st
	sys-apps/dcfldd
	net-analyzer/netcat
	net-analyzer/cryptcat
	dev-lang/perl
	userland_GNU? ( sys-apps/coreutils )"

src_compile() {
	einfo "nothing to compile"
}

src_install() {

	PERLTK_VER=$(best_version dev-perl/perl-tk)
	export PERLTK_VER=${PERLTK_VER:17:7}

	env INTERACTIVE=no INSTALL_DIR="${D}/usr" TEMP_DIR="${T}" \
		FINAL_INSTALL_DIR=/usr \
		./install-${P} \
		|| die "failed to install - please attach ${T}/air-install.log to a bug report at http://bugs.gentoo.org"

	dodoc README

	dodoc "${T}/air-install.log"

	chown -R root:0 "${D}"
	fowners root:users /usr/share/air/logs
	fperms ug+rwx /usr/share/air/logs
	if [ -p "${D}usr/share/air/air-fifo" ]; then
		fperms ug+rw /usr/share/air/air-fifo
		fowners root:users /usr/share/air/air-fifo
	fi
	fperms a+x /usr/bin/air
}

pkg_postinst() {
	elog "The author, steve@unixgurus.com, would appreciate an email of the install file /usr/share/doc/${PF}/air-install.log"
}
