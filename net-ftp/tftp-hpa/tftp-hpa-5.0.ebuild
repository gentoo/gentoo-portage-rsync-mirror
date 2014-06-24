# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tftp-hpa/tftp-hpa-5.0.ebuild,v 1.7 2014/06/24 02:26:26 vapier Exp $

DESCRIPTION="port of the OpenBSD TFTP server"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"
SRC_URI="mirror://kernel/software/network/tftp/${P}.tar.bz2"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 readline selinux tcpd"

RDEPEND="selinux? ( sec-policy/selinux-tftp )
	!net-ftp/atftp
	!net-ftp/netkit-tftp"
DEPEND="${RDEPEND}
	readline? ( sys-libs/readline )
	tcpd? ( sys-apps/tcp-wrappers )"

src_compile() {
	econf \
		$(use_with ipv6) \
		$(use_with tcpd tcpwrappers) \
		$(use_with readline) \
		|| die
	emake || die
}

src_install() {
	emake INSTALLROOT="${D}" install || die
	dodoc README* CHANGES tftpd/sample.rules

	# iputils installs this
	rm "${D}"/usr/share/man/man8/tftpd.8 || die

	newconfd "${FILESDIR}"/in.tftpd.confd-0.44 in.tftpd
	newinitd "${FILESDIR}"/in.tftpd.rc6 in.tftpd
	insinto /etc/xinetd.d
	newins "${FILESDIR}"/tftp.xinetd tftp
}
