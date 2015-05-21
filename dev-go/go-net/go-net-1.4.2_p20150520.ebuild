# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-go/go-net/go-net-1.4.2_p20150520.ebuild,v 1.2 2015/05/21 08:25:46 zmedico Exp $

EAPI=5

KEYWORDS="~amd64"
DESCRIPTION="Go supplementary network libraries"
MY_PN=${PN##*-}
GO_PN=golang.org/x/${MY_PN}
HOMEPAGE="https://godoc.org/${GO_PN}"
EGIT_COMMIT="7212a0803472eb1ec2686896a7c626528172a7a6"
SRC_URI="https://github.com/golang/${MY_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/go-1.4
	dev-go/go-text"
RDEPEND=""
S="${WORKDIR}/src/${GO_PN}"
EGIT_CHECKOUT_DIR="${S}"
STRIP_MASK="*.a"

src_unpack() {
	default
	mkdir -p src/${GO_PN%/*} || die
	mv ${MY_PN}-${EGIT_COMMIT} src/${GO_PN} || die
}

src_compile() {
	# Create a writable GOROOT in order to avoid sandbox violations.
	GOROOT="${WORKDIR}/goroot"
	cp -sR "${EPREFIX}"/usr/lib/go "${GOROOT}" || die
	rm -rf "${GOROOT}/src/${GO_PN}" \
		"${GOROOT}/pkg/linux_${ARCH}/${GO_PN}" || die
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} go install -v -x -work ${GO_PN}/... || die
}

src_test() {
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} \
		go test -run "^(Example(WithTimeout|Parse)|"$(
		echo -n '|Test(Background|TODO|WithCancel|ParentFinishesChild|'
		echo -n 'ChildFinishesFirst|Deadline|Timeout|CanceledTimeout|'
		echo -n 'Values|Allocs|SimultaneousCancels|InterlockedCancels|'
		echo -n 'LayersCancel|LayersTimeout|CancelRemoves|EntityLength|'
		echo -n 'Unescape|UnescapeEscape|Parser|NodeConsistency|Renderer|'
		echo -n 'Tokenizer|MaxBuffer|MaxBufferReconstruction|Passthrough|'
		echo -n 'BufAPI|ConvertNewlines|ReaderEdgeCases|Known|Hits|Misses|'
		echo -n 'ForeignObject|Decode|Encode|Names|Sniff|Reader|FromMeta|'
		echo -n 'XML|MarshalAndParseExtension|ParseIPv4Header|'
		echo -n 'MarshalAndParseMessageForIPv4|MarshalAndParseMessageForIPv6|'
		echo -n 'MarshalAndParseMultipartMessageForIPv4|'
		echo -n 'MarshalAndParseMultipartMessageForIPv6|IDNA|Punycode|'
		echo -n 'PunycodeErrors|MarshalHeader|ParseHeader|ICMPString|'
		echo -n 'ICMPFilter|UDPSinglePacketConnWithMultipleGroupListeners|'
		echo -n 'UDPMultiplePacketConnWithMultipleGroupListeners|'
		echo -n 'UDPPerInterfaceSinglePacketConnWithSingleGroupListener|'
		echo -n 'PacketConnConcurrentReadWriteUnicastUDP|'
		echo -n 'PacketConnReadWriteUnicastUDP|ConnUnicastSocketOptions|'
		echo -n 'PacketConnUnicastSocketOptions|ParseHeader|ICMPString|'
		echo -n 'ICMPFilter|UDPSinglePacketConnWithMultipleGroupListeners|'
		echo -n 'UDPMultiplePacketConnWithMultipleGroupListeners|'
		echo -n 'UDPPerInterfaceSinglePacketConnWithSingleGroupListener|'
		echo -n 'PacketConnConcurrentReadWriteUnicastUDP|ConnInitiatorPathMTU|'
		echo -n 'ConnResponderPathMTU|PacketConnReadWriteUnicastUDP|'
		echo -n 'ConnUnicastSocketOptions|PacketConnUnicastSocketOptions|'
		echo -n 'LimitListener|LimitListenerError|PerHost|FromURL|SOCKS5|'
		echo -n 'NodeLabel|Find|ICANN|PublicSuffix|SlowPublicSuffix|'
		echo -n 'EffectiveTLDPlusOne|SlashClean|DirResolve|Walk|Dir|MemFS|'
		echo -n 'MemFSRoot|MemFileReaddir|MemFile|MemFileWriteAllocs|WalkFS|'
		echo -n 'ParseIfHeader|WalkToRoot|MemLSCanCreate|MemLSLookup|'
		echo -n 'MemLSConfirm|MemLSNonCanonicalRoot|MemLSExpiry|MemLS|'
		echo -n 'ParseTimeout|MemPS|ReadLockInfo|ReadPropfind|'
		echo -n 'SecWebSocketAccept|HybiClientHandshake|'
		echo -n 'HybiClientHandshakeWithHeader|HybiServerHandshake|'
		echo -n 'HybiServerHandshakeNoSubProtocol|'
		echo -n 'HybiServerHandshakeHybiBadVersion|HybiShortTextFrame|'
		echo -n 'HybiShortMaskedTextFrame|HybiShortBinaryFrame|'
		echo -n 'HybiControlFrame|HybiLongFrame|HybiClientRead|'
		echo -n 'HybiShortRead|HybiServerRead|HybiServerReadWithoutMasking|'
		echo -n 'HybiClientReadWithMasking|HybiServerFirefoxHandshake|Echo|'
		echo -n 'Addr|Count|WithQuery|WithProtocol|WithTwoProtocol|'
		echo -n 'WithBadProtocol|HTTP|TrailingSpaces|DialConfigBadVersion|'
		echo -n 'SmallBuffer|ParseAuthority|Close))$') \
		-x -v ${GO_PN}/... || die $?
}

src_install() {
	insinto /usr/lib/go
	find "${WORKDIR}"/{pkg,src} -name '.git*' -exec rm -rf {} \; 2>/dev/null
	doins -r "${WORKDIR}"/{pkg,src}
}
