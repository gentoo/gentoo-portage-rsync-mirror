# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-http-persistent/net-http-persistent-2.9-r1.ebuild,v 1.1 2013/10/09 01:50:45 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Manages persistent connections using Net::HTTP plus a speed fix for Ruby 1.8."
HOMEPAGE="https://github.com/drbrain/net-http-persistent"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc test"

ruby_add_bdepend "doc? ( dev-ruby/hoe )
	test? ( dev-ruby/hoe dev-ruby/minitest )"
