# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/publicfile/publicfile-0.52-r3.ebuild,v 1.10 2013/01/01 22:27:39 hasufell Exp $

EAPI=4

inherit eutils toolchain-funcs user

DESCRIPTION="publish files through FTP and HTTP"
HOMEPAGE="http://cr.yp.to/publicfile.html"
SRC_URI="http://cr.yp.to/publicfile/${P}.tar.gz
	http://www.ohse.de/uwe/patches/${P}-filetype-diff
	http://www.publicfile.org/ftp-ls-patch"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="selinux vanilla"
RESTRICT="mirror bindist test"

RDEPEND="virtual/daemontools
	>=sys-apps/ucspi-tcp-0.83
	selinux? ( sec-policy/selinux-publicfile )
	!net-ftp/netkit-ftpd"

src_prepare() {
	# verbose build log
	epatch "${FILESDIR}"/${P}-build.patch

	# filetypes in env using daemontools
	use vanilla || epatch "${DISTDIR}"/${P}-filetype-diff

	# "normal" ftp listing
	use vanilla || epatch "${DISTDIR}"/ftp-ls-patch

	# fix for glibc-2.3.2 errno issue
	sed -i -e 's|extern int errno;|#include <errno.h>|' error.h

	# fix file collision
	sed -i configure.c \
		-e 's|/bin/httpd|/bin/publicfile-httpd|' \
		-e 's|/bin/ftpd|/bin/publicfile-ftpd|' \
		|| die "sed file collision failed"
}

src_configure() {
	tc-export AR RANLIB
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
}

src_install() {
	exeinto /usr/bin
	newexe ftpd publicfile-ftpd
	newexe httpd publicfile-httpd
	newexe configure publicfile-conf
	dodoc CHANGES README TODO
}

pkg_preinst() {
	enewgroup nofiles
	enewuser ftp -1 -1 /home/public nofiles
	enewuser ftplog -1 -1 /home/public nofiles
}

pkg_postinst() {
	if [ ! -d /home/public/httpd ]; then
		einfo "Setting up server root in /home/public"
		if [ -d /home/public ]; then
			backupdir=public.old-$(date +%s)
			einfo "Serverroot exists... backing up to ${backupdir}"
			mv /home/public /home/${backupdir}
		fi
		/usr/bin/publicfile-conf ftp ftplog /home/public `hostname`
	fi
	echo
	einfo "publichtml-httpd and public-html ftpd are serving out"
	einfo "of /home/public. Remember to start the servers with:"
	einfo "  ln -s /home/public/public-httpd /home/public/public-ftpd /service"
	echo
}
