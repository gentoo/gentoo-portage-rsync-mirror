# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti/ganeti-2.5.2-r2.ebuild,v 1.4 2013/09/12 22:29:37 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit eutils confutils bash-completion-r1 python

MY_PV="${PV/_rc/~rc}"
#MY_PV="${PV/_beta/~beta}"
MY_P="${PN}-${MY_PV}"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.ganeti.org/ganeti.git"
	inherit git-2
	KEYWORDS=""
	# you will need to pull in the haskell overlay for pandoc
	GIT_DEPEND="app-text/pandoc
		dev-python/docutils
		dev-python/sphinx
		media-libs/gd[fontconfig,jpeg,png,truetype]
		media-gfx/graphviz
		media-fonts/urw-fonts"
else
	SRC_URI="http://ganeti.googlecode.com/files/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Ganeti is a virtual server management software tool"
HOMEPAGE="http://code.google.com/p/ganeti/"

LICENSE="GPL-2"
SLOT="0"
IUSE="kvm xen lxc drbd +filestorage sharedstorage htools syslog ipv6"
REQUIRED_USE="|| ( kvm xen lxc )"

S="${WORKDIR}/${MY_P}"

DEPEND="xen? ( >=app-emulation/xen-3.0 )
	kvm? ( app-emulation/qemu )
	lxc? ( app-emulation/lxc )
	drbd? ( >=sys-cluster/drbd-8.3 )
	ipv6? ( net-misc/ndisc6 )
	htools? (
		>=dev-lang/ghc-6.10
		dev-haskell/json
		dev-haskell/curl
		dev-haskell/network
		dev-haskell/parallel )
	dev-libs/openssl
	dev-python/paramiko
	dev-python/pyopenssl
	dev-python/pyparsing
	dev-python/pycurl
	dev-python/pyinotify
	dev-python/simplejson
	net-analyzer/arping
	net-misc/bridge-utils
	net-misc/curl[ssl]
	net-misc/openssh
	net-misc/socat
	sys-apps/iproute2
	sys-fs/lvm2
	>=sys-apps/baselayout-2.0
	>=dev-lang/python-2.6
	${GIT_DEPEND}"
RDEPEND="${DEPEND}
	!app-emulation/ganeti-htools"

pkg_setup () {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		./autogen.sh
	fi
	epatch "${FILESDIR}/${PN}-fix-start-stop.patch"
	epatch "${FILESDIR}/${PN}-2.5-gentoo-start-stop-daemon.patch"

	# Force Ganeti to use python2
	python_convert_shebangs -r 2 tools
	python_convert_shebangs 2 daemons/import-export
}

src_configure () {
	local myconf
	if use filestorage ; then
		myconf="--with-file-storage-dir=/var/lib/ganeti-storage/file"
	else
		myconf="--with-file-storage-dir=no"
	fi
	if use sharedstorage ; then
		myconf="--with-shared-file-storage-dir=/var/lib/ganeti-storage/shared"
	else
		myconf="--with-shared-file-storage-dir=no"
	fi
	if use kvm && [ -f /usr/bin/qemu-kvm ] ; then
		myconf="--with-kvm-path=/usr/bin/qemu-kvm"
	fi
	econf --localstatedir=/var \
		--docdir=/usr/share/doc/${P} \
		--with-ssh-initscript=/etc/init.d/sshd \
		--with-export-dir=/var/lib/ganeti-storage/export \
		--with-os-search-path=/usr/share/ganeti/os \
		$(use_enable syslog) \
		$(use_enable htools) \
		$(use_enable htools htools-rapi) \
		${myconf}
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/ganeti-2.1.initd ganeti
	newconfd "${FILESDIR}"/ganeti.confd ganeti
	use kvm && newinitd "${FILESDIR}"/ganeti-kvm-poweroff.initd ganeti-kvm-poweroff
	use kvm && newconfd "${FILESDIR}"/ganeti-kvm-poweroff.confd ganeti-kvm-poweroff
	newbashcomp doc/examples/bash_completion ganeti
	dodoc INSTALL UPGRADE NEWS README doc/*.rst
	rm -rf "${D}"/usr/share/doc/ganeti
	docinto examples
	#dodoc doc/examples/{basic-oob,ganeti.cron,gnt-config-backup}
	dodoc doc/examples/{ganeti.cron,gnt-config-backup}
	docinto examples/hooks
	dodoc doc/examples/hooks/{ipsec,ethers}
	insinto /etc/cron.d
	newins doc/examples/ganeti.cron ganeti
	# Force Ganeti to use python2
	python_convert_shebangs -r 2 "${D}"/usr/sbin/
	python_convert_shebangs 2 "${D}"/usr/"$(get_libdir)"/ganeti/ensure-dirs

	keepdir /var/{lib,log,run}/ganeti/
	keepdir /usr/share/ganeti/os/
	keepdir /var/lib/ganeti-storage/{export,file,shared}/
}
