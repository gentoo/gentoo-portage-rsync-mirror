# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-go/go-tools/go-tools-9999.ebuild,v 1.1 2015/05/18 07:58:45 zmedico Exp $

EAPI=5
inherit git-r3

KEYWORDS=""
DESCRIPTION="Go Tools"
GO_PN=golang.org/x/${PN##*-}
HOMEPAGE="https://godoc.org/${GO_PN}"
EGIT_REPO_URI="https://go.googlesource.com/${PN##*-}"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/go-1.4
	dev-go/go-net"
RDEPEND=""
S="${WORKDIR}/src/${GO_PN}"
EGIT_CHECKOUT_DIR="${S}"
STRIP_MASK="*.a"

src_compile() {
	# Create a writable GOROOT in order to avoid sandbox violations.
	GOROOT="${WORKDIR}/goroot"
	cp -sR "${EPREFIX}"/usr/lib/go "${GOROOT}" || die
	rm -rf "${GOROOT}/src/${GO_PN}" \
		"${GOROOT}/pkg/linux_${ARCH}/${GO_PN}" || die
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} go install -v -x -work ${GO_PN}/... || die
}

src_install() {
	exeinto /usr/lib/go/bin
	doexe "${WORKDIR}"/bin/*
	insinto /usr/lib/go
	find "${WORKDIR}"/{pkg,src} -name '.git*' -exec rm -rf {} \; 2>/dev/null
	doins -r "${WORKDIR}"/{pkg,src}
	exeinto /usr/lib/go/pkg/tool/linux_amd64
	find "${GOROOT}/pkg/tool/linux_amd64" -type f -exec doexe {} \;
}
