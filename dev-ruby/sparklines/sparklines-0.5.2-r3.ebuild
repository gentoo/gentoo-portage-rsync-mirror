# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sparklines/sparklines-0.5.2-r3.ebuild,v 1.5 2014/08/05 16:00:56 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Create sparklines, small graphs to be used inline in texts"
HOMEPAGE="http://sparklines.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-macos"
IUSE=""

RDEPEND="dev-ruby/rmagick"

ruby_add_bdepend test "dev-ruby/hoe dev-ruby/tidy_table dev-ruby/dust"
