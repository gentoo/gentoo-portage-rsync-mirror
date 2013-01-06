# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/chntpw/chntpw-100627.ebuild,v 1.1 2010/07/13 11:01:55 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Offline Windows NT Password & Registry Editor"
HOMEPAGE="http://pogostick.net/~pnh/ntpasswd/"
SRC_URI="http://pogostick.net/~pnh/ntpasswd/${PN}-source-${PV}.zip"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	sed -i \
		-e '/-o/s:$(CC):$(CC) $(LDFLAGS):' \
		Makefile || die

	emake clean || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -DUSEOPENSSL -Wall" \
		LIBS="-lcrypto" || die
}

src_install() {
	dobin chntpw cpnt reged || die

	if use static; then
		dobin {chntpw,reged}.static || die
	fi

	dodoc {HISTORY,README,regedit,WinReg}.txt || die
}
