# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multipart-post/multipart-post-1.2.0.ebuild,v 1.5 2014/11/11 11:07:35 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.txt"

inherit ruby-fakegem eutils

DESCRIPTION="Adds a streamy multipart form post capability to Net::HTTP"
HOMEPAGE="http://github.com/nicksieger/multipart-post"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

each_ruby_test() {
	${RUBY} -S testrb -Ilib test || die "Tests failed."
}
